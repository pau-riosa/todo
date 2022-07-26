defmodule TodoWeb.Components.Time do
  use TodoWeb, :live_component

  def render(
        %{
          id: id,
          socket: socket,
          current_path: current_path,
          timezone: timezone,
          date: date,
          datetime: datetime,
          button_id: button_id,
          selected_timeslots: selected_timeslots
        } = assigns
      ) do
    slot_string = NaiveDateTime.to_iso8601(datetime)

    datetime_path =
      socket
      |> Routes.live_path(TodoWeb.ScheduleEventLive, slot_string)
      |> URI.decode()

    disabled = Timex.compare(datetime, Timex.today(timezone)) == -1
    weekday = Timex.weekday(datetime, :monday)
    pointer = if date == "time", do: "pointer-events-none", else: ""

    selected = Enum.member?(selected_timeslots, slot_string)

    class =
      class_list([
        {"w-full h-full p-3 justify-center items-center flex", true},
        {"bg-blue-200", selected},
        {"bg-blue-50 text-blue-600 font-bold hover:bg-blue-200 #{pointer}", not disabled},
        {"text-gray-300 cursor-default pointer-events-none", disabled}
      ])

    text = if date == "time", do: Timex.format!(datetime, "%l:%M %P", :strftime), else: ""

    assigns =
      assigns
      |> assign(disabled: disabled)
      |> assign(text: text)
      |> assign(datetime_path: datetime_path)
      |> assign(class: class)
      |> assign(datetime: datetime)
      |> assign(button_id: button_id)

    ~H"""
    <button  phx-value-id={@id} id={@id} class={@class} disabled={@disabled} phx-click="select-time" phx-value-timeslot={@datetime} >
      <%= @text %> 
    </button>
    """
  end

  def mount(socket) do
    {:ok, socket}
  end
end