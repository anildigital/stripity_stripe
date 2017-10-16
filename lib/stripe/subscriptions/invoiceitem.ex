defmodule Stripe.Invoiceitem do
  @moduledoc """


  Note: this module is name `Invoiceitem` and not `InvoiceItem` on purpose, to match the Stripe
  terminology.
  """
  use Stripe.Entity

  @type t :: %__MODULE__{
               id: Stripe.id,
               object: String.t,
               amount: integer,
               currency: String.t,
               customer: Stripe.id | Stripe.Customer.t,
               date: Stripe.timestamp,
               description: String.t,
               discountable: boolean,
               invoice: Stripe.id | Stripe.Invoice.t,
               livemode: boolean,
               metadata: %{
                 optional(String.t) => String.t
               },
               period: %{
                 start: Stripe.timestamp,
                 end: Stripe.timestamp
               },
               plan: Stripe.Plan.t | nil,
               proration: boolean,
               quantity: integer,
               subscription: Stripe.id | nil,
               subscription_item: Stripe.id | nil
             }

  defstruct [
    :id,
    :object,
    :amount,
    :currency,
    :customer,
    :date,
    :description,
    :discountable,
    :livemode,
    :metadata,
    :period,
    :plan,
    :proration,
    :quantity,
    :subscription,
    :subscription_item
  ]
end
