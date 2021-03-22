METHOD /IWNGW/IF_NOTIF_PROVIDER_EXT~GET_NOTIFICATION_TYPE.

  es_notification_type-is_groupable = space.
  es_notification_type-type_key     = iv_type_key.
  es_notification_type-version      = iv_type_version.

ENDMETHOD.