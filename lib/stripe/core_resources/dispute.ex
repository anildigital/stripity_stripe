defmodule Stripe.Dispute do
  @moduledoc """

  """
  use Stripe.Entity

  @type evidence_details :: %{
                              due_by: Stripe.timestamp,
                              has_evidence: boolean,
                              past_due: boolean,
                              submission_count: integer
                            }

  @type dispute_reason :: :duplicate | :fraudulent | :subscription_canceled | :product_unacceptable
  | :product_not_received | :unrecognized | :credit_not_processed | :general
  | :incorrect_account_details | :insufficient_funds | :bank_cannot_process
  | :debit_not_authorized | :customer_initiated

  @type dispute_status :: :warning_needs_response | :warning_under_review | :warning_closed
  | :needs_response | :under_review | :charge_refunded | :won | :lost

  @type t :: %__MODULE__{
               id: Stripe.id,
               object: String.t,
               amount: integer,
               balance_transactions: [Stripe.BalanceTransaction.t],
               charge: Stripe.id | Stripe.Charge.t,
               created: Stripe.timestamp,
               currency: String.t,
               evidence: Stripe.DisputeEvidence.t,
               evidence_details: evidence_details,
               is_charge_refundable: boolean,
               livemode: boolean,
               metadata: %{
                 optional(String.t) => String.t
               },
               reason: dispute_reason,
               status: dispute_status
             }

  defstruct [
    :id,
    :object,
    :amount,
    :balance_transactions,
    :charge,
    :created,
    :currency,
    :evidence,
    :evidence_details,
    :is_charge_refundable,
    :livemode,
    :metadata,
    :reason,
    :status
  ]
end
