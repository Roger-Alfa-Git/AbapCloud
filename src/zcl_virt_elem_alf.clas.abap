CLASS zcl_virt_elem_alf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_virt_elem_alf IMPLEMENTATION.

  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA lt_original_data TYPE STANDARD TABLE OF z_c_travel_alf WITH DEFAULT KEY.

    lt_original_data = CORRESPONDING #( it_original_data ).

    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<ls_original_data>).
      <ls_original_data>-DiscountPrice = <ls_original_data>-TotalPrice - ( <ls_original_data>-TotalPrice * ( 1 / 10 ) ).
    ENDLOOP.

    ct_calculated_data = CORRESPONDING #( lt_original_data ).

  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

    IF iv_entity = 'Z_C_TRAVEL_ALF'.
      LOOP AT it_requested_calc_elements INTO DATA(ls_calc_elements).
        APPEND 'TOTALPRICE' TO et_requested_orig_elements.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
