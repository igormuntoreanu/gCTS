  method /IWNGW/IF_NOTIF_PROVIDER_EXT~HANDLE_ACTION.
**TRY.
*CALL METHOD SUPER->/IWNGW/IF_NOTIF_PROVIDER_EXT~HANDLE_ACTION
*  EXPORTING
*    IV_NOTIFICATION_ID =
*    IV_TYPE_KEY        =
*    IV_TYPE_VERSION    =
*    IV_ACTION_KEY      =
**  IMPORTING
**    es_result          =
*    .
**  CATCH /iwngw/cx_notif_provider.
**ENDTRY.
  endmethod.