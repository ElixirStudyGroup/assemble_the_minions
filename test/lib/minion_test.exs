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

  test "Can add" do
    AssembleTheMinions.Minion.start_link(:bernard)

    count = AssembleTheMinions.Minion.current_count(:bernard)
    assert count == 0

    AssembleTheMinions.Minion.add(:bernard, 5)

    second_count = AssembleTheMinions.Minion.current_count(:bernard)
    assert second_count == 5
  end

  test 'Adding to one minion does not add to another' do
    AssembleTheMinions.Minion.start_link(:bernard)
    AssembleTheMinions.Minion.start_link(:manny)

    bernard_count = AssembleTheMinions.Minion.current_count(:bernard)
    manny_count = AssembleTheMinions.Minion.current_count(:manny)

    assert bernard_count == 0
    assert manny_count == 0

    AssembleTheMinions.Minion.add(:bernard, 5)

    new_bernard_count = AssembleTheMinions.Minion.current_count(:bernard)

    assert new_bernard_count == 5
    assert manny_count == 0
  end

  test 'Can subtract' do
    AssembleTheMinions.Minion.start_link(:fran)

    count = AssembleTheMinions.Minion.current_count(:fran)
    assert count == 0

    AssembleTheMinions.Minion.subtract(:fran, 5)

    new_count = AssembleTheMinions.Minion.current_count(:fran)

    assert new_count == -5
  end

  test 'Can multiply' do
    AssembleTheMinions.Minion.start_link(:evan)
    AssembleTheMinions.Minion.add(:evan, 5)
    # This is technically relying on code I have written being correct…
    count = AssembleTheMinions.Minion.current_count(:evan)
    assert count == 5

    AssembleTheMinions.Minion.multiply(:evan, 5)

    new_count = AssembleTheMinions.Minion.current_count(:evan)
    assert new_count == 25
  end

  test 'Can divide' do
    AssembleTheMinions.Minion.start_link(:jason)
    AssembleTheMinions.Minion.add(:jason, 27)

    count = AssembleTheMinions.Minion.current_count(:jason)
    assert count == 27

    AssembleTheMinions.Minion.divide(:jason, 3)

    new_count = AssembleTheMinions.Minion.current_count(:jason)
    assert new_count == 9
  end
end
