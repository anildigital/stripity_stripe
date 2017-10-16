defmodule Stripe.Discount do
  @moduledoc """

  """
  use Stripe.Entity

  @type t :: %__MODULE__{
               object: String.t,
               coupon: Stripe.Coupon.t,
               customer: Stripe.id,
               end: Stripe.timestamp | nil,
               start: Stripe.timestamp,
               subscription: Stripe.id
             }

  defstruct [
    :object,
    :coupon,
    :customer,
    :end,
    :start,
    :subscription
  ]
end
