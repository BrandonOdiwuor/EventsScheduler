defmodule EventsScheduler.StudentTest do
  use EventsScheduler.ModelCase

  alias EventsScheduler.Student

  @valid_attrs %{email: "some@mail.com", password: "some content", password_confirmation: "some content", name: "some content", year: 2018}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Student.changeset(%Student{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Student.changeset(%Student{}, @invalid_attrs)
    refute changeset.valid?
  end
end
