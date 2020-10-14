defmodule LocalTimestamps do
  @moduledoc """
  Timestamps in local time for Ecto `timestamps()` columns.

  Generate Ecto timestamps in local time.

  Use this library if:
  - you're using MS SQL Server
  - you want timestamp columns (`updated_at`, `inserted_at`) to be stored in local time in a `datetimeoffset(n)` column.

  Why would you do such a thing?
  - So that customers who are interacting with the database directly see the timestamps in the local time.

  It will look like this...

  | thing | inserted_at                      | updated_at                       |
  |-------|----------------------------------|----------------------------------|
  | arbie | 2020-01-02 03:04:05.123456+10:00 | 2020-01-02 13:14:15.999999+10:00 |

  Note: when retreiving the datetimes from the database using Ecto, the data will be returned in UTC time.


  ## Installation

      def deps do
        [
          {:local_timestamps, git: "https://github.com/simonmcconnell/local_timestamps.git"}
        ]
      end


  ## Usage

  Using `@timestamps_opts`:
      @timestamps_opts [
        type: TdsTypes.DateTimeOffset,
        autogenerate: {LocalTimestamps, :autogenerate, []}
      ]

  Or, supplying args to `timestamps()` directly:
      schema "things" do
        field :thing, :string

        timestamps(
          type: TdsTypes.DateTimeOffset,
          autogenerate: {LocalTimestamps, :autogenerate, []}
        )
      end


  ## Choices

  By default, it takes the later time when the [DateTime is ambiguous](https://hexdocs.pm/timex/Timex.AmbiguousDateTime.html).  This can be changed to take the earlier time by passing `:before` to `autogenerate()`.

      @timestamps_opts [
        type: TdsTypes.DateTimeOffset,
        autogenerate: {LocalTimestamps, :autogenerate, [:before]}
      ]
  """
  @spec autogenerate :: :error | DateTime.t()
  def autogenerate do
    autogenerate(:after)
  end

  @spec autogenerate(:after | :before) :: :error | DateTime.t()
  def autogenerate(ambiguity) when ambiguity in [:before, :after] do
    case Timex.local() do
      {:error, _} ->
        :error

      %DateTime{} = dt ->
        dt

      %Timex.AmbiguousDateTime{before: b, after: a} ->
        case ambiguity do
          :before -> b
          :after -> a
        end
    end
  end
end
