  method /IWNGW/IF_NOTIF_PROVIDER_EXT~HANDLE_BULK_ACTION.
**TRY.
*CALL METHOD SUPER->/IWNGW/IF_NOTIF_PROVIDER_EXT~HANDLE_BULK_ACTION
*  EXPORTING
*    IT_BULK_NOTIF   =
**  IMPORTING
**    et_notif_result =
*    .
**  CATCH /iwngw/cx_notif_provider.
**ENDTRY.
  endmethod.