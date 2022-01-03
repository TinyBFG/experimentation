defmodule Circle1 do
  @moduledoc """
    Implements basic circle functions
  """
  @pi 3.14159

  @spec area(number) :: number
  @doc """
    Computes the area of the circle
  """
  def area(r), do: r*r*@pi

  @spec circumference(number) :: number
  @doc """
    Computes circumference of a circle
  """
  def circumference(r), do: 2*r*@pi
end

defmodule Rectangle1 do
  @moduledoc """
    Implements basic rectangle functions
  """

  @spec area({number, number}) :: number
  @doc """
    Computes the area of a rectangle
  """
  def area({a, b}) do
    a * b
  end
end

defmodule Geometry1 do
  @moduledoc """
    Implement basic geometric functions
  """
  @pi 3.14159
  @doc """
    Computes area of either a rectangle, square, or circle
  """
  def area({:rectangle, a, b}), do: a * b
  def area({:square, a}), do: a * a
  def area({:circle, r}), do: r * r * @pi
  def area(unknown), do: {:error, {:unknown_shape, unknown}}

end

defmodule TestNum1 do
  @moduledoc """
    Test numbers for various traits
  """

  @spec test(number) :: atom
  @doc """
    Determines if a number is positive, 0, or negative
  """
  def test(x) when is_number(x) and x < 0, do: :negative
  def test(0), do: :zero
  def test(x) when is_number(x) and x > 0, do: :positive
end

defmodule Polymorphic1 do
  @moduledoc """
    Example of how one function can be designed to accept multiple types of data
  """

  @doc """
    Doubles the value as long as it is either a number or a binary
  """
  def double(x) when is_number(x), do: 2 * x
  def double(x) when is_binary(x), do: x <> x
end

defmodule Fact1 do
  @moduledoc """
    Example of recursion using multiclauses
  """

  @doc """
    Multiplies the input number by all of the integers that come before it stopping at 0
  """
  def fact(0), do: 1
  def fact(n), do: n * fact(n - 1)
end

defmodule ListHelper1 do
  @moduledoc """
    Example of looping using recursion and multiclauses
  """

  @doc """
    Adds all of the elements in a list
  """
  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)
end

defmodule Conditional_macros1 do
  @moduledoc """
    Shows an example of each of the 4 main conditional macros if, unless, cond, and case
  """

  @doc """
    Uses an if-else statement to return the larger of the 2 values
  """
  def max1(a, b) do
    if a >= b, do: a, else: b
  end

  @doc """
    Uses an unless statement to return the largest of 2 values
  """
  def max2(a, b) do
    unless a >= b, do: b, else: a
  end

  @doc """
    Uses a cond block to return the largest of the 2 numbers
  """
  def max3(a, b) do
    cond do
      a >= b -> a
      true -> b
    end
  end

  @doc """
    Uses a case construct to return the largest of 2 numbers
  """
  def max4(a, b) do
    case a >= b do
      true -> a
      false -> b
    end
  end
end

defmodule Extract_user do
  @moduledoc """
    Examples for the special with form
  """

  @doc """
    Helper function for extracting the user login
  """
  defp extract_login(%{"login" => login}), do: {:ok, login}
  defp extract_login(_), do: {:error, "login missing"}

  @doc """
    Helper function for extracting the user email
  """
  defp extract_email(%{"email" => email}), do: {:ok, email}
  defp extract_email(_), do: {:error, "email missing"}

  @doc """
    Helper function for extracting the user password
  """
  defp extract_password(%{"password" => password}), do: {:ok, password}
  defp extract_password(_), do: {:error, "password missing"}

  @doc """
    Example of how to use case to extract the information
    Purpose is to show that case in this situation can get very complex and nasty
  """
  def extract_user1(user) do
    case extract_login(user) do
      {:error, reason} -> {:error, reason}

      {:ok, login} ->
        case extract_email(user) do
          {:error, reason} -> {:error, reason}

          {:ok, email} ->
            case extract_password(user) do
              {:error, reason} -> {:error, reason}

              {:ok, password} ->
                %{login: login, email: email, password: password}
            end
        end
    end
  end

  @doc """
    Example of how to use a with clause
  """
  def extract_user2(user) do
    with {:ok, login} <- extract_login(user),
          {:ok, email} <- extract_email(user),
          {:ok, password} <- extract_password(user) do
          {:ok, %{login: login, email: email, password: password}}
    end
  end

  def extract_user3(user) do
    case Enum.filter(
           ["login", "email", "password"],
           &(not Map.has_key?(user, &1))
         ) do
      [] ->
        {:ok, %{
          login: user["login"],
          email: user["email"],
          password: user["password"]
        }}

      missing_fields ->
        {:error, "missing fields: #{Enum.join(missing_fields, ", ")}"}
    end
  end
end

defmodule Tail_call_practice do

  def list_len_notail([]), do: 0
  def list_len_notail([head | tail]) do

    1 + list_len_notail(tail)

  end

  def list_len_tail(list), do: do_list_len_tail(list, 0)

    defp do_list_len_tail([], current_sum), do: IO.puts(current_sum)
    defp do_list_len_tail([head | tail], current_sum) do

      new_sum = 1 + current_sum
      do_list_len_tail(tail, new_sum)

    end

  def range_notail(num1, num2), do: do_range_notail(num1 + 1, num2 - 1)
    defp do_range_notail(num1, num2) when num1 > num2, do: IO.puts("Invalid, num1 < num2")
    defp do_range_notail(num1, num2) when num1 == num2, do: IO.puts(num2)
    defp do_range_notail(num1, num2) do
      range_notail(num1 + 1, num2)
      IO.puts(num1)
    end

  def range_tail(num1, num2) when num1 > num2, do: IO.puts("Invalid, num1 < num2")
  def range_tail(num1, num2) when num1 == num2 - 1, do: IO.puts("Done")
  def range_tail(num1, num2) do
    num1 = num1 + 1
    IO.puts(num1)
    range_tail(num1, num2)
  end

  def positive_tail(list), do: do_positive_tail(list, [])

    defp do_positive_tail([], positives), do: IO.puts(positives)
    defp do_positive_tail([head | tail], positives) do
      if head >= 0 do
        positives = positives ++ [head]
        do_positive_tail(tail, positives)
      else
        do_positive_tail(tail, positives)
      end
    end

end
