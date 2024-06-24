<div>
    <form wire:submit.prevent="pay">
        <div class="card p-2">
            @if($is_loading)
            <img src="{{ asset('loading.svg') }}" class="img img-fluid" alt="">
            @if($start_polling)
            <div wire:poll='checkStatus()'></div>
            @endif
            @else
            <div class="form-group">
                <label for="">Select Meter</label>
                <select  class="form-control" wire:model='meter_id' >
                     @foreach ($meters as $meter)
                    <option value="{{ $meter->id }}">{{ $meter->meter_no }}</option>
                     @endforeach
                </select>
            </div>


                 <label for="customRange1" class="form-label">Amount in Litres</label>

                <input type="range" wire:model.live='water_amount' min="5" max="10000000" step="5" class="form-range my-2" id="customRange1">
                <p>
                    <b> {{ $water_amount }} Litres  </b>
                </p>
                <div class="form-group">
                    <label for="">Amount</label>
                    <input type="text" disabled value="{{ $water_amount*env('PRICE_PER_LITER') }}" class="form-control" >
                </div>
                <div class="form-group">
                    <label for="">Phone</label>
                    <input type="number" placeholder="0XXXXXXXXX" wire:model='phone' class="form-control" >
                    @error('phone')
                        <span class="text-danger">
                            {{ $message }}
                        </span>
                    @enderror
                </div>

            <button class="form-control btn btn-sm btn-primary" wire:loading.remove>
                Buy Now
            </button>
            @endif

            @if($message != null)
            {!! $message !!}
            @endif
       </div>
    </form>
</div>

@script
<script>
    $wire.on('payment-complete', () => {
        window.location.href = "{{ route('home') }}";
    });
</script>
@endscript

