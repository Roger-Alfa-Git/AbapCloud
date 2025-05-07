@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption - Booking Supllement'
@Metadata.allowExtensions: true
define view entity Z_C_BOOKSUPPL_ALF
  as projection on Z_I_BOOKSUPPL_ALF
{
  key travel_id                   as TravelID,
  key booking_id                  as BookingID,
  key booking_supplement_id       as BookingSupplementID,
      @ObjectModel.text.element: ['SupplementDescription']
      supplement_id               as SupplementID,
      _SupplementText.Description as SupplementDescription : localized,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                       as Price,
      @Semantics.currencyCode: true
      currency                    as CurrencyCode,
      last_changed_at             as LastChangedAt,
      /* Associations */
      _Travel  : redirected to z_c_travel_alf,
      _Booking : redirected to parent z_c_booking_alf,
      _Product,
      _SupplementText
}
