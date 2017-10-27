from jira import JIRA

# see https://jira.magnolia-cms.com/browse/SERVICES-346

options = { 'server': 'https://jira.magnolia-cms.com', }
jira = JIRA(options, basic_auth=('bandersen', 'YOUR_PASSWD'))

issue_dict = {
    'project': 'SERVICES',
    'summary': 'Test (Please Delete)',
    'description': 'bradley sent this from a python script.',
    'issuetype': 'Task',
}

new_issue = jira.create_issue(fields=issue_dict)
