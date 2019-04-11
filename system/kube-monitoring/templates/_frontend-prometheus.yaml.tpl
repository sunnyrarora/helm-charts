- job_name: 'prometheus-collector-federation'
  scrape_interval: 60s
  scrape_timeout: 55s

  honor_labels: true
  metrics_path: '/federate'

  params:
    'match[]':
      - '{__name__=~"^active_job_.+"}'
      - '{__name__=~"^aggregated:.+"}'
      - '{__name__=~"^ad_.+"}'
      - '{__name__=~"^alertmanager_.+"}'
      - '{__name__=~"^apiserver_.+"}'
      - '{__name__=~"^arc_.+"}'
      - '{__name__=~"^arista_.+$"}'
      - '{__name__=~"^authenticated_user_requests"}'
      - '{__name__=~"^backup_.+"}'
      - '{__name__=~"^bind_.+"}'
      - '{__name__=~"^bird_.+"}'
      - '{__name__=~"^blackbox_.+"}'
      - '{__name__=~"^broker_.+"}'
      - '{__name__=~"^canary_.+"}'
      - '{__name__=~"^concourse_.+"}'
      - '{__name__=~"^cinder_nanny_.+"}'
      - '{__name__=~"^container_cpu_cfs_.+"}'
      - '{__name__=~"^container_fs.+"}'
      - '{__name__=~"^container_memory_.+"}'
      - '{__name__=~"^container_network_.+"}'
      - '{__name__=~"^container_spec_.+"}'
      - '{__name__=~"^container_scrape_error"}'
      - '{__name__=~"^container_start_time_seconds"}'
      - '{__name__=~"^container_task_state"}'
      - '{__name__=~"^datapath_.+"}'
      - '{__name__=~"^dnsmasq.+"}'
      - '{__name__=~"^elasticsearch_.+"}'
      - '{__name__=~"^elektra_.+"}'
      - '{__name__=~"^etcd_.+"}'
      - '{__name__=~"^go_.+"}'
      - '{__name__=~"^hermes_.+"}'
      - '{__name__=~"^http_.+"}'
      - '{__name__=~"^inframonitor_.+"}'
      - '{__name__=~"^ingress_.+"}'
      - '{__name__=~"^ipmi_.+"}'
      - '{__name__=~"^jump_.+"}'
      - '{__name__=~"^keystone_.+"}'
      - '{__name__=~"^klog_.+"}'
      - '{__name__=~"^kube_.+"}'
      - '{__name__=~"^kubelet_.+"}'
      - '{__name__=~"^limes_.+"}'
      - '{__name__=~"^logstash_.+"}'
      - '{__name__=~"^machine_cpu_cores"}'
      - '{__name__=~"^machine_memory_bytes"}'
      - '{__name__=~"^maia_.+"}'
      - '{__name__=~"^memcached.+"}'
      - '{__name__=~"^metrics_.+"}'
      - '{__name__=~"^netapp_.+"}'
      - '{__name__=~"^neutron_asr1k.+"}'
      - '{__name__=~"^nginx_.+"}'
      - '{__name__=~"^node_.+"}'
      - '{__name__=~"^nova_nanny_.+"}'
      - '{__name__=~"^ntp_drift_seconds$"}'
      - '{__name__=~"^openstack_.+"}'
      - '{__name__=~"^pg_.+"}'
      - '{__name__=~"^pgbouncer_.+"}'
      - '{__name__=~"^probe_success$"}'
      - '{__name__=~"^probe_dns_lookup_time_seconds$"}'
      - '{__name__=~"^probe_duration_seconds$"}'
      - '{__name__=~"^probe_http_duration_seconds$"}'
      - '{__name__=~"^probe_http_status_code$"}'
      - 'probe_ssl_earliest_cert_expiry{region_probed_from={{.Values.global.region|quote}}}'
      - '{__name__=~"^process_.+"}'
      - '{__name__=~"^prometheus_.+"}'
      - '{__name__=~"^puma_.+"}'
      - '{__name__=~"^quay_.+"}'
      - '{__name__=~"^rabbitmq_.+"}'
      - '{__name__=~"^repo_sync.+"}'
      - '{__name__=~"^rest_client_.+"}'
      - '{__name__=~"^scheduler_.+"}'
      - '{__name__=~"^scrape_duration_seconds"}'
      - '{__name__=~"^security_group_(max|total)_entanglement$"}'
      - '{__name__=~"^skydns_.+"}'
      - '{__name__=~"^snmp_asa_cfwHardwareStatusValue"}'
      - '{__name__=~"^snmp_asr_.+"}'
      - '{__name__=~"^snmp_arista_dot1qVlanFdbId"}'
      - '{__name__=~"^snmp_f5_.+"}'
      - '{__name__=~"^snmp_n7k_.+"}'
      - '{__name__=~"^sql_openstack_.+"}'
      - '{__name__=~"^mysql_global_status_.+"}'
      - '{__name__=~"^mysql_global_variables_.+"}'
      - '{__name__=~"^mysql_info_.+"}'
      - '{__name__=~"^statsd_.+"}'
      - '{__name__=~"^swift_.+"}'
      - '{__name__=~"^unbound_.+"}'
      - '{__name__=~"^up"}'
      - '{__name__=~"^uwsgi_.+"}'
      - '{__name__=~"^vasa_.+"}'
      - '{__name__=~"^vice_president_.+"}'
      - '{__name__=~"^vcenter_datastore_.+$"}'
      - '{__name__=~"^vcenter_vcenter_api_session_info$"}'
      - '{__name__=~"^vcenter_disk_numberWrite_summation$"}'
      - '{__name__=~"^vcenter_nanny.*"}'
      - '{__name__=~"^vcenter_esx_node_info$"}'
      - '{__name__=~"^vcenter_vcenter_node_info$"}'
      - '{__name__=~"^vcenter_SR17629377811$"}'
      - '{__name__=~"^vcenter_dvswitch_out_of_memory$"}'
      - '{__name__=~"^vcenter_SR17595168510$"}'
      - '{__name__=~"^webhook_.+"}'
      - '{__name__=~"^admission|daemonset|deployment|disruption|endpoint|job|namespace|petset|replicaset|serviceaccount.+"}'
      - '{__name__=~"^ns_exporter.+"}'
      - '{__name__=~"^total"}'
      - '{__name__=~"^success"}'
      - '{__name__=~"^latency"}'
      - '{job="dns-sd"}'

  #add region label to all metrics, don't delete this without knowing what you are doing...
  relabel_configs:
     - action: replace
       target_label: region
       replacement: {{ required ".Values.global.region undefined" .Values.global.region }}

  metric_relabel_configs:
    - action: replace
      source_labels: [__name__]
      target_label: __name__
      regex: aggregated:(.+)
      replacement: $1

  static_configs:
    - targets:
      - 'prometheus-collector.{{ .Release.Namespace }}.svc.cluster.local:9090'
