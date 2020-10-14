defmodule LocalTimestamps do
  @moduledoc """
  Timestamps in local time for Ecto `timestamps()` columns.

  ## Usage

  Using `@timestamps_opts`:
      @timestamps_opts [
        type: TsqlTypes.DateTimeOffset,
        autogenerate: {LocalTimestamps, :autogenerate, []}
      ]

  Or, supplying args to `timestamps()` directly:
      schema "things" do
        field :thingo, :string

        timestamps(
          type: TsqlTypes.DateTimeOffset,
          autogenerate: {LocalTimestamps, :autogenerate, []}
        )
      end
  """
  def autogenerate do
    case Timex.local() do
      {:error, _} ->
        :error

      %DateTime{} = dt ->
        dt

      %Timex.AmbiguousDateTime{after: dt} ->
        dt
    end
  end
end
