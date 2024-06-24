<div>
  @if(!auth()->user()->is_admin)
    <div wire:poll.45s='detectLeakage()'>
        @if($leackage['leakage'])

    <div class="alert alert-danger">
       ℹ Warning! Water Leackage of about {{ $leackage['suspected_amount'] }} Litres Detected!
    </div>

    @else
    <div class="alert alert-info">
      ✅  We are good, No leackage detected!.
    </div>
    @endif
    </div>
    @else  
    @if($leackage['leakage'])

    <div class="">
       ℹ 
    </div>

    @else
    <div class="">
      ✅ 
    </div>
    @endif
    @endif

</div>
