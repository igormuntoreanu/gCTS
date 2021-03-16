METHOD /IWNGW/IF_NOTIF_PROVIDER_EXT~GET_NOTIFICATION_TYPE_TEXT.

  DATA: lv_text       TYPE string,
        lv_subtitle   TYPE string,
        ls_type_text  TYPE /iwngw/if_notif_provider_ext=>ty_s_notification_type_text.

  lv_text = TEXT-001. "Purchase Order: &1 was &2

  REPLACE '&1' WITH '{EKKO-EBELN}'  INTO lv_text.
  REPLACE '&2' WITH '{DECISION}'    INTO lv_text.

  ls_type_text-name  = /iwngw/if_notif_provider_ext=>gc_template_names-template_public.
  ls_type_text-value = lv_text.
  APPEND ls_type_text TO et_type_text.

  ls_type_text-name  = /iwngw/if_notif_provider_ext=>gc_template_names-template_sensitive.
  ls_type_text-value = lv_text.
  APPEND ls_type_text TO et_type_text.

ENDMETHOD.