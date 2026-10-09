module WorkflowsHelper
  def default_defination_json
    {
    "id": "wf_001",
    "name": "Unlock alddd",
    "enabled": true,
    "trigger": {
    "type": "http",
    "path": "/t/4f1f9a2c9b7f4f2a9b2e2f7d4a3c1b0e"
  },
  "steps": [
  {
  "type": "filter",
  "conditions": [
  {
  "path": "type",
  "op": "eq",
  "value": "lock.unlock"
},
{
"path": "success",
"op": "eq",
"value": false
}
]
},
{
"type": "transform",
"ops": [
{
"op": "default",
"path": "actor_name",
"value": "Unknown"
},
{
"op": "template",
"to": "title",
"template": "Event {{type}} by {{actor_name}}"
}
]
},
{
"type": "http_request",
"method": "POST",
"url": "https://hooks.slack.com/services/XXX/YYY/ZZZ",
"headers": {
"Content-Type": "application/json"
},
"body": {
"mode": "custom",
"value": {
"text": "{{title}}"
}
}
}
]
}
end
end
