<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('user_watters', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id');
            $table->string('meter_no');
            $table->string('active_tokens')->nullable();
            $table->string('balance')->default(0);
            $table->string('remaining')->default(0);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_watters');
    }
};
