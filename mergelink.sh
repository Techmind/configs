#/bin/sh
echo "automerge and auto link issue, requires export JIRA_LOGIN=X; export JIRA_PASSWORD=Y"
echo "usage $0 REALTY-NUM MNT-NUM"
git checkout $1 && git checkout $2 && git merge $1

echo "{
  \"type\": {
      \"name\": \"Раскладка\"
  },
  \"inwardIssue\": {
      \"key\": \"$1\"
  },
  \"outwardIssue\": {
      \"key\": \"$2\"
  }
}" > link.json

curl -D- -u "$JIRA_LOGIN:$JIRA_PASSWORD" -X POST -H "Content-Type:application/json" -H "X-Atlassian-Token: nocheck" -d "@link.json" "https://$JIRA_HOST/rest/api/latest/issueLink"
