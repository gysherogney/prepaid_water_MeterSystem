<div>


    <div class="card-body">

        <h4>Add customer</h4>


        @if($show_adwater)
        <form wire:submit.prevent='addWaterBalance' class="row my-2">
            <div class="form-group col-md-3">
                <label for="">Customer</label>
                <input type="text" disabled placeholder="jina kamili .. " class="form-control" wire:model="name">
                @error('name')
                    <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>


            <div class="form-group col-md-3">
                <label for="">Balance (<b>Litres</b>)</label>
                <input type="water_amount"  class="form-control" wire:model="water_amount">
                @error('water_amount')
                    <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>


            <div class="form-group col-md-3">
                <label for="">Meter No (<b>That needs to be recharged</b>)</label>
                <input type="number"  class="form-control" wire:model="meter_no">
                @error('meter_no')
                    <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>


           <div class="col-md-3 form-group">
            <label for=""><br></label>
            <button wire:loading.remove type="submit" class="btn btn-primary form-control my-2">Sajili</button>
           </div>
        </form>
        @else
        <form wire:submit.prevent='register' class="row my-2">
            <div class="form-group col-md-3">
                <label for="">Jina kamili </label>
                <input type="text" placeholder="jina kamili .. " class="form-control" wire:model="name">
                @error('name')
                    <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>
            <div class="form-group col-md-3">
                <label for="">Simu</label>
                <input type="number" placeholder="0XXXXXXXXX" class="form-control" wire:model="phone">
                @error('phone')
                    <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>

            <div class="form-group col-md-3">
                <label for="">Email</label>
                <input type="email"  class="form-control" wire:model="email">
                @error('email')
                    <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>


           <div class="col-md-3 form-group">
            <label for=""><br></label>
            <button wire:loading.remove type="submit" class="btn btn-primary form-control my-2">Sajili</button>
           </div>
        </form>
        @endif

        <table class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Meters</th>
                    <th>
                        Action
                    </th>
                </tr>
            </thead>
            <tbody>
                @foreach ($users as $key=>$user)


                <tr>
                    <td>{{ $key+1 }}</td>
                    <td>{{ $user->name }}</td>
                    <td>{{ $user->email }}</td>
                    <td>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Meter</th>
                                    <th>Balance(L)</th>
                                    <th>Leakage</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach ($user->meters as $meter )
                                <tr>
                                    <td>{{ $meter->meter_no }} </td>
                                    <td>{{ $meter->balance }}</td>
                                    <td>
                                        @livewire('detect-leackage',['meterId'=>$meter->id])
                                    </td>
                                    <td><a href="#" wire:confirm='Are you sure you want to delete  {{ $meter->meter_no }}?' wire:click='deleteMeter({{ $meter->id }})' >delete</a></td>
                                </tr>
                                @endforeach

                            </tbody>
                        </table>
                         
                    </td>
                    <td>
                        <a wire:confirm='Are you sure you want to generate meter for  {{ $user->name }}?' wire:click='generateMeter({{ $user->id }})'  class="btn btn-sm btn-primary">Generate Metter</a>
                        <a wire:confirm='Are you sure you want to delete {{ $user->name }}?' wire:click='delete({{ $user->id }})' class="btn btn-sm btn-danger">Delete Customer</a>
                        @if($show_adwater)
                        <a  wire:click='showAddWaterForm({{ $user->id }})' class="btn btn-sm btn-info">Cancel Water balance</a>
                        @else
                        <a  wire:click='showAddWaterForm({{ $user->id }})' class="btn btn-sm btn-success">Add Water balance</a>

                        @endif

                    </td>

                </tr>
                @endforeach
            </tbody>

        </table>


    </div>
</div>
