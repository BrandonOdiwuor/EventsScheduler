defmodule EventsScheduler.EventTest do
  use EventsScheduler.ModelCase

  alias EventsScheduler.Event

  @valid_attrs %{creator: "some content", description: "some content", eventtime: "2010-04-17 14:00:00", imagetag: "some content", location: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end
end
