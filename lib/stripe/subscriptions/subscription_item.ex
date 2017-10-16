defmodule Stripe.SubscriptionItem do
  @moduledoc """

  """
  use Stripe.Entity

  @type t :: %__MODULE__{
               id: Stripe.id,
               object: String.t,
               created: Stripe.timestamp,
               metadata: %{
                 optional(String.t) => String.t
               },
               plan: Stripe.Plan.t,
               quantity: non_neg_integer
             }

  defstruct [
    :id,
    :object,
    :created,
    :metadata,
    :plan,
    :quantity
  ]
end
