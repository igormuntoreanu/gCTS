METHOD send_notification.

  DATA: lt_nf               TYPE /iwngw/if_notif_provider=>ty_t_notification,
        ls_nf               TYPE LINE OF /iwngw/if_notif_provider=>ty_t_notification,
        lt_user             TYPE STANDARD TABLE OF /iwngw/if_notif_provider=>ty_s_notification_recipient,
        ls_user             TYPE /iwngw/if_notif_provider=>ty_s_notification_recipient,
        lt_parameter_values TYPE /iwngw/if_notif_provider=>ty_t_notification_parameter,
        ls_parameter_values TYPE LINE OF /iwngw/if_notif_provider=>ty_t_notification_parameter,
        ls_parameter        TYPE LINE OF /iwngw/if_notif_provider=>ty_t_notification_param_bundle,
        lt_parameter        TYPE /iwngw/if_notif_provider=>ty_t_notification_param_bundle.

  TRY.
      DATA(lv_system_uuid) = cl_uuid_factory=>create_system_uuid( ).
      ls_nf-id             = lv_system_uuid->create_uuid_x16( ).

      ls_user-id = iv_initiator+2.
      APPEND ls_user TO lt_user. CLEAR ls_user.

      ls_nf-type_key                 = 'ZPO_PRICE_NOTIFICATION'.
      ls_nf-type_version             = '9'.
      ls_nf-recipients               = lt_user[].

      ls_parameter_values-name         = 'EKKO-EBELN'.
      ls_parameter_values-type         = 'Edm.String'.
      ls_parameter_values-value        = iv_po.
      ls_parameter_values-is_sensitive = abap_false.
      APPEND ls_parameter_values TO lt_parameter_values. CLEAR: ls_parameter_values.

      ls_parameter_values-name         = 'DECISION'.
      ls_parameter_values-type         = 'Edm.String'.

      IF iv_approved IS NOT INITIAL.
        ls_parameter_values-value        = TEXT-002. "Approved
      ELSE.
        ls_parameter_values-value        = TEXT-003. "Rejected
      ENDIF.

      ls_parameter_values-is_sensitive = abap_false.
      APPEND ls_parameter_values TO lt_parameter_values. CLEAR: ls_parameter_values.

      ls_parameter-language            = sy-langu.
      ls_parameter-parameters          = lt_parameter_values.
      APPEND ls_parameter TO lt_parameter.

      ls_nf-parameters = lt_parameter[].

      APPEND ls_nf TO lt_nf.

      TRY.
          /iwngw/cl_notification_api=>create_notifications(
            EXPORTING
              iv_provider_id  = 'ZPO_PRICE_NOTIFICATION'
              it_notification = lt_nf ).

          COMMIT WORK AND WAIT.

        CATCH /iwngw/cx_notification_api INTO DATA(lrx_api).
          EXIT.
      ENDTRY.
    CATCH cx_root.
  ENDTRY.

ENDMETHOD.