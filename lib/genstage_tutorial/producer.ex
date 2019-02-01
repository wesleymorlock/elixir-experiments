defmodule GenstageExample.Producer do
    use GenStage

    @odd_consumers_count 5
    @even_consumers_count 5

    def start_link(initial \\ 0) do
        GenStage.start_link(__MODULE__, initial, name: __MODULE__) # initial being the starting count
    end

    def init(counter) do
        # send(self(), :init)

        {:producer, counter} # labels this worker as a :producer
    end
        
    def handle_demand(demand, state) when demand > 0 do
        # sends number of values requested by a consumer, starting from current state
        # demand will default to 1000
        
        events = Enum.to_list(state..(state + demand - 1))
        { :noreply, events, state + demand }
    end

    def handle_info(:init, state) do
        Enum.each(1..@odd_consumers_count, fn(_) ->
            ConsumersSupervisor.start_consumer(GenstageExample.EvenFilterer)
        end)

        Enum.each(1..@even_consumers_count, fn(_) ->
        ConsumersSupervisor.start_consumer(GenstageExample.EvenFilterer)
        end)
        
        {:noreply, [], state}
    end
    def handle_info(_, state) do
        {:noreply, [], state}
    end
end