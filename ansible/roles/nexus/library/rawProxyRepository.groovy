import groovy.json.JsonSlurper

def input = new JsonSlurper().parseText(args)

def name = input.name
def remoteUrl = input.remoteUrl

repository.createRawProxy(name, remoteUrl)
