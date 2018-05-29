until $(curl --output /dev/null --silent --head --fail http://$ELASTICSEARCH_HOST:$ELASTICSEARCH_PORT); do echo "Waiting for Elasticsearch to be online"; sleep 5; done
sleep 3
TEST=$(curl -I http://elasticsearch:9200/elastalert_status | head -n1)
if [[ $TEST == *"404"* ]]; then
  elastalert-create-index --host $ELASTICSEARCH_HOST --port $ELASTICSEARCH_PORT --no-auth --no-ssl --index elastalert_status --url-prefix "" --old-index ""
else
    echo "Elastalert index already exists in Elasticsearch."
fi

elastalert --config /etc/elastalert/config.yaml
