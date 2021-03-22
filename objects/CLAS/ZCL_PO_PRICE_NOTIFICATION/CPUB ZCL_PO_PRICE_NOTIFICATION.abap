class ZCL_PO_PRICE_NOTIFICATION definition
  public
  inheriting from /IWNGW/CL_NOTIF_PROVIDER_ABS
  final
  create public .

public section.

  types:
    ty_xvbap TYPE STANDARD TABLE OF vbapvb .

  class-methods SEND_NOTIFICATION
    importing
      !IV_PO type EKKO-EBELN
      !IV_APPROVED type ABAP_BOOL
      !IV_INITIATOR type WFSYST-INITIATOR .

  methods /IWNGW/IF_NOTIF_PROVIDER_EXT~GET_NOTIFICATION_PARAMETERS
    redefinition .
  methods /IWNGW/IF_NOTIF_PROVIDER_EXT~GET_NOTIFICATION_TYPE
    redefinition .
  methods /IWNGW/IF_NOTIF_PROVIDER_EXT~GET_NOTIFICATION_TYPE_TEXT
    redefinition .
  methods /IWNGW/IF_NOTIF_PROVIDER_EXT~HANDLE_ACTION
    redefinition .
  methods /IWNGW/IF_NOTIF_PROVIDER_EXT~HANDLE_BULK_ACTION
    redefinition .