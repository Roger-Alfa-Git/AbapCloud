CLASS zcl_ext_update_ent_alf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ext_update_ent_alf IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    MODIFY ENTITIES OF z_i_travel_alf
           ENTITY Travel
           UPDATE FIELDS ( agency_id description )
           WITH VALUE #( ( travel_id = '00000067'
                           agency_id = '070028'
                           description = 'New external Update' ) )
           FAILED DATA(failed)
           REPORTED DATA(reported).

    READ ENTITIES OF z_i_travel_alf
            ENTITY Travel
            FIELDS ( agency_id description )
            WITH VALUE #( ( travel_id = '00000068' ) )
            RESULT DATA(lt_travel_data)
            FAILED failed
            REPORTED reported.

    COMMIT ENTITIES.

    IF failed IS INITIAL.
      out->write( 'Commit Successfull' ).
    ELSE.
      out->write( 'Commit Failed' ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
