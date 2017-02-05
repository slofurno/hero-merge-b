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

    assert {:ok, _} = MergeRequest.check_hero(c, a ,b)

    d = %Hero{
      weaknesses: ["weakness1", "weakness3", "weakness4"],
      powers: ["power1", "power3", "power6"]
    }

    assert {:error, _} = MergeRequest.check_hero(d, a ,b)

    e = %Hero{
      weaknesses: ["weakness1", "weakness2", "weakness3", "weakness4"],
      powers: ["power1", "power3", "power7"]
    }

    assert {:error, _} = MergeRequest.check_hero(e, a ,b)

    assert {:error, _} = MergeRequest.check_hero(%MergeRequest{hero: e, from: [1,2,3]})

  end

  test "creating hero" do
    invalid_hero = %Hero{
      weaknesses: ["weakness1", "weakness2"],
      powers: ["power1", "power2", "power3"],
      attributes: %Attributes{}
    }

    assert Hero.valid?(invalid_hero) == false

    almost_valid_hero = %Hero{
      hero_name: "name",
      real_name: "name",
      gender: "Female",
      weaknesses: [],
      powers: [],
      attributes: %Attributes{
        intelligence: 50,
        strength: 50,
        speed: 50,
        durability: 50,
        power: 50,
        combat: 50
      }
    }

    assert Hero.valid?(almost_valid_hero) == false

    valid_hero = %Hero{
      hero_name: "name",
      real_name: "name",
      gender: "Female",
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

  test "merging attributes" do
    a = %Attributes{
      intelligence: 50,
      strength: 50,
      speed: 50,
      durability: 50,
      power: 50,
      combat: 50
    }

    b = %Attributes{
      intelligence: 20,
      strength: 20,
      speed: 20,
      durability: 20,
      power: 20,
      combat: 20
    }

    invalid_attribute = %Attributes{
      intelligence: 40,
      strength: 20,
      speed: 20,
      durability: 50,
      power: 20,
      combat: 20
    }

    assert Attributes.from_sources?(invalid_attribute, [a,b]) == false

    valid_attribute = %Attributes{
      intelligence: 50,
      strength: 20,
      speed: 20,
      durability: 50,
      power: 20,
      combat: 20
    }

    assert Attributes.from_sources?(valid_attribute, [a,b]) == true
  end
end
