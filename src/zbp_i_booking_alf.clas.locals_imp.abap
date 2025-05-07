CLASS lhc_Booking DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS calculateTotalFlightPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~calculateTotalFlightPrice.

    METHODS validateStatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR Booking~validateStatus.

    METHODS get_features FOR FEATURES IMPORTING keys REQUEST
    requested_features FOR booking RESULT result.

ENDCLASS.

CLASS lhc_Booking IMPLEMENTATION.

  METHOD calculateTotalFlightPrice.

    IF NOT keys IS INITIAL.

      zcl_aux_travel_det_alf=>calculate_price( it_travel_id = VALUE #( FOR GROUPS <booking> OF booking_key IN keys GROUP BY booking_key-travel_id WITHOUT MEMBERS ( <booking>  ) ) ).

    ENDIF.

  ENDMETHOD.

  METHOD validateStatus.

    READ ENTITY z_i_travel_alf\\Booking
        FIELDS ( booking_status )
        WITH VALUE #( FOR <row_key> IN keys ( %key = <row_key>-%key ) )
        RESULT DATA(lt_booking_result).

    LOOP AT lt_booking_result INTO DATA(ls_booking_result).

      CASE ls_booking_result-booking_status.

        WHEN 'N'. " New
        WHEN 'X'. " Cancelled
        WHEN 'B'. " Blocked

        WHEN OTHERS.
          APPEND VALUE #( %key      = ls_booking_result-%key ) TO failed-booking.

          APPEND VALUE #( %key = ls_booking_result-%key
                          %msg = new_message(
                                   id       = 'ZMC_TRAVEL_ALF'
                                   number   = '008'
                                   severity = if_abap_behv_message=>severity-error
                                   v1       = ls_booking_result-booking_status )
                           %element-booking_status = if_abap_behv=>mk-on ) TO reported-booking.

      ENDCASE.

    ENDLOOP.


  ENDMETHOD.

  METHOD get_features.
    READ ENTITIES OF z_i_travel_alf
        ENTITY Booking
        FIELDS ( booking_id booking_date customer_id booking_status )
            WITH VALUE #( FOR keyval IN keys ( %key = keyval-%key ) )
        RESULT DATA(lt_booking_result).

    result = VALUE #( FOR ls_travel IN lt_booking_result
                        ( %key = ls_travel-%key
                        %assoc-_BookingSupplement = if_abap_behv=>fc-o-enabled ) ).

  ENDMETHOD.

ENDCLASS.
