
## Check connection to Nuxeo server
BASE_URL=${BASE_URL:-http://localhost:8080/nuxeo}
NUXEO_STATUS=$(curl -Isw "%{http_code}\n" -o /dev/null ${BASE_URL}/login.jsp)
[[ "${NUXEO_STATUS}" != "200" ]] && { echo "! Connection to ${BASE_URL} failed (${NUXEO_STATUS})."; exit 2; }

JQ_CMD="cat"
if ! type "$cmd" > /dev/null 2>&1;
then
    JQ_CMD="jq"
fi

## Make sure '/default-domain/UserWorkspaces/Administrator' exists
curl -su Administrator:Administrator \
-H 'Content-Type:application/json' -H 'enrichers-user:userprofile' -H 'properties: *' \
${BASE_URL}/api/v1/me/ |${JQ_CMD}

folders="/default-domain /default-domain/UserWorkspaces /default-domain/UserWorkspaces/Administrator"
for folder in $folders
do
    HTTP_CODE=$(curl -IsLu Administrator:Administrator -o /dev/null -w '%{http_code}' ${BASE_URL}/api/v1/path${folder})
    if [ "$HTTP_CODE" != "200" ]
    then
        echo "! ${folder} does not exist."
        echo "* Please log in the Web UI http://localhost:8080/nuxeo/ui first and retry."
        exit 1
    fi
done

## Create File document 'blank.pdf' if it does not exist
HTTP_CODE=$(curl -IsLu Administrator:Administrator -o /dev/null -w '%{http_code}' ${BASE_URL}/api/v1/path/default-domain/UserWorkspaces/Administrator/WEBUI-1142-1)
if [ "$HTTP_CODE" != "200" ]
then
    echo "* Creating File document 'blank.pdf' ..."
    curl -su Administrator:Administrator -XPOST \
    -H "properties:*" -H 'Content-Type:application/json' \
    ${BASE_URL}/api/v1/repo/default/path/default-domain/UserWorkspaces/Administrator \
    -D /tmp/response-headers.txt \
    -d '{ "entity-type":"document", "name":"WEBUI-1142-1","type":"WEBUI-1142", "properties": { "dc:title":"WEBUI-1142-1"} }' \
    |${JQ_CMD}
    echo "* Created"

## Attach file to blank.pdf
    echo "* Attaching file to document 'blank.pdf' ..."
    curl -su Administrator:Administrator -XPOST -H'properties:*' \
    ${BASE_URL}/api/v1/automation/Blob.AttachOnDocument \
    -F request='{"params":{"document":"/default-domain/UserWorkspaces/Administrator/WEBUI-1142-1", "xpath": "webui-1142:pdf_bundle"},"context":{}}' \
    -F input=@blank.pdf \
    > /dev/null
fi

## 
curl -su Administrator:Administrator \
${BASE_URL}/api/v1/repo/default/path/default-domain/UserWorkspaces/Administrator/WEBUI-1142-1 \
-H 'Content-Type: application/json' \
-H 'translate-directoryEntry: label' -H 'fetch-document: properties,lock' \
-H 'fetch-directoryEntry: parent' -H 'fetch-task: actors' \
-H 'enrichers-document: hasContent,firstAccessibleAncestor,permissions,breadcrumb,preview,favorites,subscribedNotifications,thumbnail,renditions,pendingTasks,runnableWorkflows,runningWorkflows,collections,audit,subtypes,tags,publications' \
-H 'enrichers-blob: appLinks,preview' -H 'properties: *' \
|${JQ_CMD}

echo
echo "* Done."

