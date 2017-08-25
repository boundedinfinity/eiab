#!/usr/bin/python

from ansible.module_utils.basic import AnsibleModule
from ansible.module_utils.urls import open_url
from ansible.module_utils._text import to_bytes, to_native, to_text
import json

def make_result(changed=False, data=None, previous=[]):
    result = {'changed': changed, 'data': {}}
    if data:
        result['data'] = data
    for p in previous:
        if 'changed' in p:
            if p['changed'] == True:
                result['changed'] = True
    return result

def make_call(module, method, path, content_type=None, body=None):
    url = "http://%s/%s" % (module.params.get('host'), path)
    j = None
    headers=None
    data=None
    
    if content_type:
        headers = { 'Content-Type': content_type, }
    
    if body:
        data = json.dumps(body)
    
    try:
        r = open_url(url,
            method=method,
            headers=headers,
            data=data,
            url_username=module.params.get('username'),
            url_password = module.params.get('password'),
            force_basic_auth = True,
        )
        
        if r is not None:
            b = r.read()
            if b != "":
                j = json.loads(b)
    except Exception as e:
        module.fail_json(msg=to_native(e))
    
    return j

def list_scripts(module):
    return make_call(module, 'GET', 'service/siesta/rest/v1/script')

def upload_script(module, name, content):
    return make_call(module, 'POST', 'service/siesta/rest/v1/script', 
        content_type = 'application/json',
        body = { 'name': name, 'type': 'groovy', 'content': content, }
    )

def run_script(module, name, body=None):
    output = make_call(module, 'POST', 
        "service/siesta/rest/v1/script/%s/run" % (name), 
        content_type = 'text/plain', body = body
    )
    j = None
    try:
        if output['result'] != "":
            j = json.loads(output['result'])
    except Exception as e:
        module.fail_json(msg=to_native(e))
    return j
    
def ensure_script(module, name, content):
    scripts = list_scripts(module)
    found = False
    changed = False
    for script in scripts:
        if script['name'] == name:
            found = True
            break
    if not found:
        upload_script(module, name, content)
        changed = True
    return make_result(changed=changed)

def repo_list(module):
    script_name = 'list_repo'
    result = ensure_script(module, script_name, """
        def repos = []

        repository.getRepositoryManager().browse().each { repo ->
            repos.push([
                'name': repo.getName()
            ])
        }

        return groovy.json.JsonOutput.toJson(repos)
    """)
    return make_result(data=run_script(module, script_name), previous=[result])

def ensure_repo(module, script_name, script_content, script_args):
    rl_result = repo_list(module)
    found = False
    changed = False
    es_result = {}
    rs_result = {}
    for repo in rl_result['data']:
        if repo['name'] == module.params.get('name'):
            found = True
            break
    if not found:
        es_result = ensure_script(module, script_name, script_content)
        rs_result = run_script(module, script_name, body=script_args)
        changed = True
    return make_result(changed=changed, previous=[rl_result, es_result, rs_result])

def ensure_raw_proxy(module):
    return ensure_repo(module, 'create_raw_proxy',
        """
            import groovy.json.JsonSlurper
            def input = new JsonSlurper().parseText(args)
            def name = input.name
            def remote_url = input.remote_url
            repository.createRawProxy(name, remote_url)
            groovy.json.JsonOutput.toJson(['status': "success", "msg":"", "name": name, "remote_url": remote_url])
        """,
        {
            'name': module.params.get('name'),
            'remote_url': module.params.get('remote_url'),
        }
    )

def ensure_yum_proxy(module):
    return ensure_repo(module, 'create_yum_proxy',
        """
            import groovy.json.JsonSlurper
            def input = new JsonSlurper().parseText(args)
            def name = input.name
            def remote_url = input.remote_url
            repository.createYumProxy(name, remote_url)
            groovy.json.JsonOutput.toJson(['status': "success", "msg":"", "name": name, "remote_url": remote_url])
        """,
        {
            'name': module.params.get('name'),
            'remote_url': module.params.get('remote_url'),
        }
    )

def validate(module):
    valid = True
    params = module.params
    if params.get('type') == 'raw_proxy':
        if module.params.get('remote_url') == None:
            module.fail_json(msg="'remote_url' missing")
            valid = False
    return valid

def main():

    module = AnsibleModule(
        argument_spec = dict(
            type = dict(default=None, required=True, type='str', choices=[
                'bower_group', 'bower_hosted', 'bower_proxy',
                'docker_group', 'docker_hosted', 'docker_proxy',
                'gitlfs_hosted',
                'maven2_group', 'maven2_hosted', 'maven2_proxy',
                'npm_group', 'npm_hosted', 'npm_proxy',
                'nuget_group', 'nuget_hosted', 'nuget_proxy',
                'pypi_group', 'pypi_hosted', 'pypi_proxy',
                'raw_group', 'raw_hosted', 'raw_proxy',
                'rubygems_group', 'rubygems_hosted', 'rubygems_proxy',
                'yum_proxy',
            ]),
            username = dict(default=None, type='str'),
            password = dict(default=None, type='str', no_log=True),
            host = dict(default='localhost:8081', type='str'),
            name = dict(required=True, type='str'),
            remote_url = dict(required=True, type='str'),
            force_basic_auth = dict(default=True, type='bool'),
        )
    )
    
    result = {}
    
    if module.params.get('type') == 'raw_proxy':
        result = ensure_raw_proxy(module)
    elif module.params.get('type') == 'yum_proxy':
        result = ensure_yum_proxy(module)
    else:
        module.fail_json(msg="type '%s' not implemented" % (module.params.get('type')))
    
    module.exit_json(changed=result['changed'], data=result['data'])
    # module.exit_json(changed=False, data=result)


if __name__ == '__main__':  
    main()
