defmodule Stripe.Invoice do
  @moduledoc """
  Work with Stripe invoice objects.

  You can:

  - Create an invoice
  - Retrieve an invoice
  - Update an invoice

  Does not take options yet.

  Stripe API reference: https://stripe.com/docs/api#invoice
  """
  use Stripe.Entity
  alias Stripe.Util

  @type t :: %__MODULE__{
               id: Stripe.id,
               object: String.t,
               amount_due: integer,
               application_fee: integer,
               attempt_count: non_neg_integer,
               attempted: boolean,
               charge: Stripe.id | Stripe.Charge.t,
               closed: boolean,
               currency: String.t,
               customer: Stripe.id,
               date: Stripe.timestamp,
               description: String.t,
               discount: Stripe.Discount.t,
               ending_balance: integer,
               forgiven: boolean,
               lines: Stripe.List.of(Stripe.LineItem.t),
               livemode: boolean,
               metadata: %{
                 optional(String.t) => String.t
               },
               next_payment_attempt: Stripe.timestamp,
               paid: boolean,
               period_end: Stripe.timestamp,
               period_start: Stripe.timestamp,
               receipt_number: String.t,
               starting_balance: integer,
               statement_descriptor: String.t,
               subscription: Stripe.id | Stripe.Subscription.t,
               subscription_proration_date: Stripe.timestamp,
               subtotal: integer,
               tax: integer | nil,
               tax_percent: integer | nil,
               total: integer,
               webhooks_delivered_at: Stripe.timestamp,
             }

  defstruct [
    :id,
    :object,
    :amount_due,
    :application_fee,
    :attempt_count,
    :attempted,
    :charge,
    :closed,
    :currency,
    :customer,
    :date,
    :description,
    :discount,
    :ending_balance,
    :forgiven,
    :lines,
    :livemode,
    :metadata,
    :next_payment_attempt,
    :paid,
    :period_end,
    :period_start,
    :receipt_number,
    :starting_balance,
    :statement_descriptor,
    :subscription,
    :subscription_proration_date,
    :subtotal,
    :tax,
    :tax_percent,
    :total,
    :webhooks_delivered_at
  ]

  @plural_endpoint "invoices"

  @doc """
  Create an invoice.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, opts)
  end

  @doc """
  Retrieve an invoice.
  """
  @spec retrieve(String.t, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end

  @doc """
  Update an invoice.

  Takes the `id` and a map of changes.
  """
  @spec update(String.t, map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, opts)
  end

  @doc """
  Retrieve an upcoming invoice.
  """
  @spec upcoming(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def upcoming(changes = %{customer: _customer}, opts \\ []) do
    endpoint = @plural_endpoint <> "/upcoming"
    Stripe.Request.retrieve(changes, endpoint, opts)
  end

  @doc """
  List all invoices.
  """
  @spec list(map, Keyword.t) :: {:ok, Stripe.List.t} | {:error, Stripe.api_error_struct}
  def list(params \\ %{}, opts \\ []) do
    endpoint = @plural_endpoint
    Stripe.Request.retrieve(params, endpoint, opts)
  end

  @doc """
  Pay an invoice.
  """
  @spec pay(t | String.t, map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def pay(invoice, params \\ %{}, opts \\ []) do
    id = Util.normalize_id(invoice)
    endpoint = @plural_endpoint <> "/" <> id <> "/pay"
    Stripe.Request.create(endpoint, params, opts)
  end
end
