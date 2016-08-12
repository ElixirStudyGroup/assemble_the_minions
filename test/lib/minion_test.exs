defmodule AssembleTheMinions.MinionTest do
  use ExUnit.Case
  doctest AssembleTheMinions.Minion

  test "Returns a hello message" do
    AssembleTheMinions.Minion.start_link(:kevin)

    message = AssembleTheMinions.Minion.say_hello(:kevin)

    assert message == "Hello from kevin"
  end

  test "Can return the count and increment it" do
    AssembleTheMinions.Minion.start_link(:jorge)

    count = AssembleTheMinions.Minion.current_count(:jorge)

    assert count == 0

    AssembleTheMinions.Minion.count(:jorge)

    second_count = AssembleTheMinions.Minion.current_count(:jorge)

    assert second_count == 1
  end

  test "Changing on minion's count doesn't affect another's" do
    AssembleTheMinions.Minion.start_link(:kevin)
    AssembleTheMinions.Minion.start_link(:jorge)

    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.count(:kevin)

    kevin_count = AssembleTheMinions.Minion.current_count(:kevin)
    jorge_count = AssembleTheMinions.Minion.current_count(:jorge)

    assert jorge_count == 0

    assert kevin_count == 2
  end

  test "Can add to the count" do
    AssembleTheMinions.Minion.start_link(:jorge)
    AssembleTheMinions.Minion.add(:jorge, 2)
    assert 2 = AssembleTheMinions.Minion.current_count(:jorge)
  end

  test "Can subtract from the count" do
    AssembleTheMinions.Minion.start_link(:jorge)
    AssembleTheMinions.Minion.count(:jorge)
    AssembleTheMinions.Minion.count(:jorge)
    AssembleTheMinions.Minion.count(:jorge)
    AssembleTheMinions.Minion.subtract(:jorge, 1)
    assert 2 = AssembleTheMinions.Minion.current_count(:jorge)
  end

  test "Can multiply the count" do
    AssembleTheMinions.Minion.start_link(:jorge)
    AssembleTheMinions.Minion.count(:jorge)
    AssembleTheMinions.Minion.count(:jorge)
    AssembleTheMinions.Minion.multiply(:jorge, 3)
    assert 6 = AssembleTheMinions.Minion.current_count(:jorge)
  end

  test "Can divide the count" do
    AssembleTheMinions.Minion.start_link(:jorge)
    AssembleTheMinions.Minion.count(:jorge)
    AssembleTheMinions.Minion.count(:jorge)
    AssembleTheMinions.Minion.divide(:jorge, 2)
    assert 1 = AssembleTheMinions.Minion.current_count(:jorge)
  end

  test "Can't create negative count" do
    AssembleTheMinions.Minion.start_link(:jorge)
    AssembleTheMinions.Minion.count(:jorge)
    AssembleTheMinions.Minion.subtract(:jorge, 2)
    assert 0 = AssembleTheMinions.Minion.current_count(:jorge)
  end

  test "Can't create fractional count" do
    AssembleTheMinions.Minion.start_link(:jorge)
    AssembleTheMinions.Minion.count(:jorge)
    AssembleTheMinions.Minion.count(:jorge)
    AssembleTheMinions.Minion.count(:jorge)
    AssembleTheMinions.Minion.divide(:jorge, 2)
    assert 1 = AssembleTheMinions.Minion.current_count(:jorge)
  end

  test "Can't use negative input" do
    AssembleTheMinions.Minion.start_link(:jorge)
    catch_error AssembleTheMinions.Minion.add(:jorge, -1)
  end

  test "Can't use fractional input" do
    AssembleTheMinions.Minion.start_link(:jorge)
    catch_error AssembleTheMinions.Minion.add(:jorge, 0.5)
  end
end
