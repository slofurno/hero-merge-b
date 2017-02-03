defmodule HeromergeTest do
  use ExUnit.Case
  alias Heromerge.Hero
  alias Heromerge.MergeRequest
  alias Heromerge.Hero.Attributes
  doctest Heromerge

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "merging heroes" do
    a = %Hero{
      weaknesses: ["weakness1", "weakness2"],
      powers: ["power1", "power2", "power3"]
    }

    b = %Hero{
      weaknesses: ["weakness3", "weakness4"],
      powers: ["power4", "power5", "power6"]
    }

    c = %Hero{
      weaknesses: ["weakness1", "weakness2", "weakness3", "weakness4"],
      powers: ["power1", "power3", "power6"]
    }

    assert MergeRequest.valid?(c, a ,b) == true

    d = %Hero{
      weaknesses: ["weakness1", "weakness3", "weakness4"],
      powers: ["power1", "power3", "power6"]
    }

    assert MergeRequest.valid?(d, a ,b) == false

    e = %Hero{
      weaknesses: ["weakness1", "weakness2", "weakness3", "weakness4"],
      powers: ["power1", "power3", "power7"]
    }

    assert MergeRequest.valid?(e, a ,b) == false
  end

  test "creating hero" do
    invalid_hero = %Hero{
      weaknesses: ["weakness1", "weakness2"],
      powers: ["power1", "power2", "power3"],
      attributes: %Attributes{}
    }

    assert Hero.valid?(invalid_hero) == false

    valid_hero = %Hero{
      weaknesses: ["weakness1", "weakness2"],
      powers: ["power1", "power2", "power3"],
      attributes: %Attributes{
        intelligence: 50,
        strength: 50,
        speed: 50,
        durability: 50,
        power: 50,
        combat: 50
      }
    }

    assert Hero.valid?(valid_hero) == true
  end
end