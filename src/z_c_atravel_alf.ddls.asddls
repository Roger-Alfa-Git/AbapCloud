@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption - Travel'
@Metadata.allowExtensions: true
define root view entity Z_C_ATRAVEL_ALF
  as projection on Z_I_TRAVEL_ALF
{

  key travel_id          as TravelID,
      @ObjectModel.text.element: [ 'AgencyName' ]
      agency_id          as AgencyID,
      _Agency.Name       as AgencyName,
      @ObjectModel.text.element: [ 'CustomerName' ]
      customer_id        as CustomerID,
      _Customer.LastName as CustomerName,
      begin_date         as BeginDate,
      end_date           as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee        as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price        as TotalPrice,
      @Semantics.currencyCode: true
      currency_code      as CurrencyCode,
      overall_status     as TravelStatus,
      description        as Description,
      last_changed_at    as LastChangedAt,
      /* Associations */
      _Booking : redirected to composition child z_c_abooking_alf,
      _Agency,
      _Customer

}
