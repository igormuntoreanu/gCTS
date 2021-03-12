*&---------------------------------------------------------------------*
*& Report ZTESTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zteste.

DATA: lt_poitem  TYPE STANDARD TABLE OF bapimepoitem,
      lt_poitemx TYPE STANDARD TABLE OF bapimepoitemx,
      ls_poitemx TYPE bapimepoitemx,
      lt_return  TYPE STANDARD TABLE OF bapiret2.

CALL FUNCTION 'BAPI_PO_GETDETAIL1'
  EXPORTING
    purchaseorder = '4500000001'
  TABLES
    return        = lt_return
    poitem        = lt_poitem.

LOOP AT lt_return TRANSPORTING NO FIELDS WHERE type CA 'EAX'.
  DATA(lv_error) = abap_true.
ENDLOOP.

IF lv_error IS INITIAL.
  LOOP AT lt_poitem ASSIGNING FIELD-SYMBOL(<fs_poitem>).
    <fs_poitem>-delete_ind = 'S'. "Block

    ls_poitemx-po_item  = <fs_poitem>-po_item.
    ls_poitemx-po_itemx = abap_true.

    APPEND ls_poitemx TO lt_poitemx.
    CLEAR ls_poitemx.
  ENDLOOP.

  REFRESH lt_return.

  CALL FUNCTION 'BAPI_PO_CHANGE'
    EXPORTING
      purchaseorder = '4500000001'
    TABLES
      return        = lt_return
      poitem        = lt_poitem
      poitemx       = lt_poitemx.

  LOOP AT lt_return TRANSPORTING NO FIELDS WHERE type CA 'EAX'.
    lv_error = abap_true.
  ENDLOOP.

  IF lv_error IS INITIAL.
    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
  ENDIF.

ENDIF.