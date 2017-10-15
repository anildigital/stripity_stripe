defmodule Stripe.Customer do
  @moduledoc """
  Work with Stripe customer objects.

  You can:

  - Create a customer
  - Retrieve a customer
  - Update a customer
  - Delete a customer

  Does not yet render lists or take options.

  Stripe API reference: https://stripe.com/docs/api#customer

  """
  use Stripe.Entity
  alias Stripe.Util

  @type address :: %{
                     city: String.t,
                     country: String.t,
                     line1: String.t,
                     line2: String.t,
                     postal_code: String.t,
                     state: String.t
                   }

  @type shipping :: %{
                      address: address,
                      carrier: String.t,
                      name: String.t,
                      phone: String.t,
                      tracking_number: String.t
                    }

  @type t :: %__MODULE__{
               id: Stripe.id,
               object: String.t,
               account_balance: integer,
               business_vat_id: String.t,
               created: Stripe.timestamp,
               currency: String.t,
               default_source: Stripe.id | Stripe.Source.t,
               delinquent: boolean,
               description: String.t,
               discount: Stripe.Discount.t | nil,
               email: String.t,
               livemode: boolean,
               metadata: %{
                 optional(String.t) => String.t
               },
               shipping: shipping,
               sources: Stripe.List.of(Stripe.Source.t),
               subscriptions: Stripe.List.of(Stripe.Subscription.t)
             }

  defstruct [
    :id,
    :object,
    :account_balance,
    :business_vat_id,
    :created,
    :currency,
    :default_source,
    :delinquent,
    :description,
    :discount,
    :email,
    :livemode,
    :metadata,
    :shipping,
    :sources,
    :subscriptions
  ]

  @plural_endpoint "customers"

  @doc """
  Create a customer.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, opts)
  end

  @doc """
  Retrieve a customer.
  """
  @spec retrieve(String.t, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end

  @doc """
  Update a customer.

  Takes the `id` and a map of changes.
  """
  @spec update(String.t, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, opts)
  end

  @doc """
  Delete a customer.
  """
  @spec delete(t | String.t, list) :: :ok | {:error, Stripe.api_error_struct}
  def delete(customer, opts \\ []) do
    id = Util.normalize_id(customer)
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.delete(endpoint, %{}, opts)
  end

  @doc """
  List all customers.
  """
  @spec list(map, Keyword.t) :: {:ok, Stripe.List.t} | {:error, Stripe.api_error_struct}
  def list(params \\ %{}, opts \\ []) do
    endpoint = @plural_endpoint
    Stripe.Request.retrieve(params, endpoint, opts)
  end
end
