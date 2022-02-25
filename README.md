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

***SELINUX*** <br/>
On distributions which have SELinux enabled out-of-the-box you will need to either re-context the files or set SELinux into Permissive mode in order for docker-elk to start properly. For example on Redhat and CentOS, the following will apply the proper context:NUX*** <br/>
```
$chcon -R system_u:object_r:admin_home_t:s0 docker-elk/
```
#### Elastic Search
- /etc/elasticsearch/elasticsearch.yml <br/>
```
network.host: <localhost>
```
Restart Elasticsearch:<br/>
```
$sudo systemctl enable elasticsearch
```

#### Update
Test Elasticsearch service bin sending HTTP request: <br/>
```
$curl -x GET "localhost:9200"
```
YOu should see: <br/>
```
Output
{
  "name" : "8oSCBFJ",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "1Nf9ZymBQaOWKpMRBfisog",
  "version" : {
    "number" : "6.5.2",
    "build_flavor" : "default",
    "build_type" : "rpm",
    "build_hash" : "9434bed",
    "build_date" : "2018-11-29T23:58:20.891072Z",
    "build_snapshot" : false,
    "lucene_version" : "7.5.0",
    "minimum_wire_compatibility_version" : "5.6.0",
    "minimum_index_compatibility_version" : "5.0.0"
  },
  "tagline" : "You Know, for Search"
}
```
