defmodule MinimalTodoD do
  @spec start() :: no_return()
  def start do
    filename = IO.gets("Please type the filename \n") |> String.trim()
    readArchive(filename)
  end

  @spec readArchive(String.t(), boolean()) :: String.t()
  def readArchive(fileName, nextCommand \\ true) do
    case File.read(fileName) do
      {:ok, body} ->
        data =
          body
          |> parse

        if nextCommand do
          getNextCommand(data)
        end

        data

      {:error, msg} ->
        raise msg
    end
  end

  def parse(body) do
    [header | lines] = String.split(body, ~r(\r\n|\r|\n))
    titles = tl(csvSplit(header))
    parseLine(lines, titles)
  end

  def csvSplit(text) do
    String.split(text, ",")
  end

  def sameSize(left, right) do
    Enum.count(left) === Enum.count(right)
  end

  @spec parseLine(Enum.t(), Enum.t()) :: MapSet.t()
  def parseLine(lines, headers) do
    Enum.reduce(lines, %{}, fn line, accumulator ->
      [todoName | fields] = csvSplit(line)

      if sameSize(fields, headers) do
        line_data = Enum.zip(headers, fields) |> Enum.into(%{})
        Map.merge(accumulator, %{todoName => line_data})
      else
        accumulator
      end
    end)
  end

  def getNextCommand(data) do
    prompt = "a) Add, r) Read, d) Delete, l) Load, s) Save ou q) Sair "

    command =
      IO.gets("Enter a command:#{prompt}")
      |> String.trim()
      |> String.downcase()

    case command do
      "a" ->
        addTodo(data)

      "r" ->
        readTodo(data)

      "d" ->
        deleteTodo(data)

      "l" ->
        loadTodo(data)

      "s" ->
        saveTodo(data)

      "q" ->
        "Tchau :P"

      _ ->
        IO.puts("Invalid command")
        getNextCommand(data)
    end
  end

  @spec fieldsFromUser(any) :: {any, binary}
  def fieldsFromUser(name) do
    field = IO.gets("Enter the #{name} of the task:") |> String.trim()

    case field do
      _ -> {name, field}
    end
  end

  @spec getFields(map) :: list
  def getFields(data) do
    data[hd(Map.keys(data))] |> Map.keys()
  end

  @spec getTodoName(map()) :: String.t()
  def getTodoName(data) do
    name = IO.gets("Enter the name of the item:") |> String.trim()

    if Map.has_key?(data, name) do
      IO.puts("Item already exists")
      getTodoName(data)
    else
      name
    end
  end

  @spec addTodo(map) :: nil | <<_::64>>
  def addTodo(data) do
    todoName = getTodoName(data)

    titles = getFields(data)

    fields = Enum.map(titles, &fieldsFromUser(&1))

    newTodo = %{todoName => Enum.into(fields, %{})}

    newData = Map.merge(data, newTodo)

    getNextCommand(newData)
  end

  @spec readTodo(map, any) :: nil | <<_::64>>
  def readTodo(data, next_command? \\ true) do
    items = Map.keys(data)
    IO.puts("You have the following todos:")

    Enum.each(items, &IO.puts(&1))

    if next_command? do
      getNextCommand(data)
    end
  end

  @spec deleteTodo(map) :: nil | <<_::64>>
  def deleteTodo(data) do
    todo = IO.gets("Enter the todo to delete:") |> String.trim()

    if Map.has_key?(data, todo) do
      new_data = Map.drop(data, [todo])
      IO.puts("#{todo} deleted")
      getNextCommand(new_data)
    else
      IO.puts("#{todo} not found")
      readTodo(data, false)
      deleteTodo(data)
    end
  end

  @spec loadTodo(map) :: MapSet.t()
  def loadTodo(data) do
    filename = IO.gets("Enter the filename to load:") |> String.trim()
    newData = readArchive(filename, false)

    merged = Map.merge(data, newData)
    merged
  end

  @spec prepareCsv(map()) :: String.t()
  def prepareCsv(data) do
    headers = ["Item" | getFields(data)]
    items = Map.keys(data)

    itemRows = Enum.map(items, &[&1 | Map.values(data[&1])])
    rows = [headers | itemRows]

    row_strings = Enum.map(rows, &Enum.join(&1, ","))

    Enum.join(row_strings, "\n")
  end

  @spec saveTodo(map()) :: fun()
  def saveTodo(data) do
    filename = IO.gets("Enter the filename to save:") |> String.trim()

    IO.puts("Saving todo...")

    csv = prepareCsv(data)

    case File.write(filename, csv) do
      :ok ->
        IO.puts("Todo saved")
        getNextCommand(data)

      {:error, msg} ->
        IO.puts("Error saving todo: #{msg}")
        getNextCommand(data)
    end

    getNextCommand(data)
  end
end
