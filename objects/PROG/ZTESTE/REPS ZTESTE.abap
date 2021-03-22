*&---------------------------------------------------------------------*
*& Report ZTESTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zteste.

DATA: gt_poitem  TYPE STANDARD TABLE OF bapimepoitem,
      gt_poitemx TYPE STANDARD TABLE OF bapimepoitemx,
      gs_poitemx TYPE bapimepoitemx,
      gt_return  TYPE STANDARD TABLE OF bapiret2.

CALL FUNCTION 'BAPI_PO_GETDETAIL1'
  EXPORTING
    purchaseorder = '4500000001'
  TABLES
    return        = gt_return
    poitem        = gt_poitem.

LOOP AT gt_return TRANSPORTING NO FIELDS WHERE type CA 'EAX'.
  DATA(gv_error) = abap_true.
ENDLOOP.

IF gv_error IS INITIAL.
  LOOP AT gt_poitem ASSIGNING FIELD-SYMBOL(<gs_poitem>).
    <gs_poitem>-delete_ind = 'S'. "Block

    gs_poitemx-po_item  = <gs_poitem>-po_item.
    gs_poitemx-po_itemx = abap_true.

    APPEND gs_poitemx TO gt_poitemx.
    CLEAR gs_poitemx.
  ENDLOOP.

  REFRESH gt_return.

  CALL FUNCTION 'BAPI_PO_CHANGE'
    EXPORTING
      purchaseorder = '4500000001'
    TABLES
      return        = gt_return
      poitem        = gt_poitem
      poitemx       = gt_poitemx.

  LOOP AT gt_return TRANSPORTING NO FIELDS WHERE type CA 'EAX'.
    gv_error = abap_true.
  ENDLOOP.

  IF gv_error IS INITIAL.
    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
  ENDIF.

ENDIF.