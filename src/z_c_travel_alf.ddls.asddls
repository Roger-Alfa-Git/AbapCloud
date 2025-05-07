@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption - Travel'
@Metadata.allowExtensions: true
define root view entity z_c_travel_alf
  as projection on Z_I_TRAVEL_ALF
{

  key     travel_id          as TravelID,
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
          @Semantics.amount.currencyCode: 'CurrencyCode'
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_VIRT_ELEM_ALF'
  virtual DiscountPrice : /dmo/total_price,
          /* Associations */
          _Booking : redirected to composition child z_c_booking_alf,
          _Agency,
          _Currency,
          _Customer

}
