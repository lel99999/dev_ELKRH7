# dev_ELKRH7
ELK (Elastic Search, Logstash, Kibana) Deployment &amp; Development

#### Base Requirements
Host setup
- Docker Engine version 17.05 or newer
- Docker Compose version 1.20.0 or newer
- 1.5 GB of RAM
information_source Especially on Linux, make sure your user has the required permissions to interact with the Docker daemon.

By default, the stack exposes the following ports: <br/>

- 5044: Logstash Beats input
- 5000: Logstash TCP input
- 9600: Logstash monitoring API
- 9200: Elasticsearch HTTP
- 9300: Elasticsearch TCP transport
- 5601: Kibana
