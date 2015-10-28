desc "Register slow broker"
task :default do
  require 'json'

  cf "push"
  cf "delete-service-broker slow -f"
  cf "create-service-broker slow foo bar http://foo:bar@#{broker_url}"
  cf "enable-service-access slow-service"

  print "\nSUCCESS:\n"
  cf "marketplace -s slow-service"
end

def broker_url
  apps = cf_curl('/v2/apps?q=name:slow-broker')
  routes = cf_curl(apps['resources'][0]['metadata']['url'] + '/routes')
  route = routes['resources'][0]['entity']
  domain = cf_curl(route['domain_url'])
  [route['host'], domain['entity']['name']].join('.')
end

def cf_curl(arg)
  JSON.parse(`cf curl '#{arg}' | grep -v deprecated`)
end

def cf(arg)
  sh "cf #{arg}"
end
