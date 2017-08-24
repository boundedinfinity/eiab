#!/usr/bin/python

from ansible.module_utils.basic import AnsibleModule
from ansible.module_utils.urls import open_url
from ansible.module_utils._text import to_bytes, to_native, to_text
import json

def list_scripts(module):
    url = "http://%s/service/siesta/rest/v1/script" % (module.params.get('host'))
    j = None
    
    try:
        r = open_url(url,
            method='GET',
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

def provision_repo_script(module):
    url = "http://%s/service/siesta/rest/v1/script" % (module.params.get('host'))
    body = {
        'name': 'raw_proxy',
        'type': 'groovy',
        'content': """
        import groovy.json.JsonSlurper

        def input = new JsonSlurper().parseText(args)

        def name = input.name
        def remote_url = input.remote_url

        repository.createRawProxy(name, remote_url)
        """,
    }
    headers = {
        'Content-Type': 'application/json',
    }
    j = None
    
    try:
        r = open_url(url,
            method='POST', 
            headers=headers, 
            data=json.dumps(body),
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

def provision_repo(module):
    # http -a admin:admin123 POST http://10.0.0.12:8081/service/siesta/rest/v1/script/raw_proxy/run 
    # Content-Type:text/plain body='{ "name": "releases.hashicorp.com2", "remoteUrl": "https://releases.hashicorp.com" }'
    
    url = "http://%s/service/siesta/rest/v1/script/%s/run" % (module.params.get('host'), 'raw_proxy')
    body = {
        'name': module.params.get('name'),
        'remote_url': module.params.get('remote_url'),
    }
    headers = {
        'Content-Type': 'text/plain',
    }
    j = None
    
    try:
        r = open_url(url,
            method='POST', 
            headers=headers, 
            data=json.dumps(body),
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

def main():

    module = AnsibleModule(
        argument_spec = dict(
            username = dict(default=None, type='str'),
            password = dict(default=None, type='str', no_log=True),
            host = dict(default='localhost:8081', type='str'),
            name = dict(required=True, type='str'),
            remote_url = dict(required=True, type='str')
        )
    )
    
    l = list_scripts(module)
    found = False
    for i in l:
        if i['name'] == 'raw_proxy':
            found = True
            break
    
    if not found:
        x = provision_repo_script(module)
    
    y = provision_repo(module)
    module.exit_json(changed=False, meta=l)


if __name__ == '__main__':  
    main()
