const Asm = @import("./asm.zig").Asm;
const interrupts = @import("./interrupts.zig");
const Uart = @import("./drivers/uart.zig").Uart;

var uart = Uart{};

const MTIME_PTR: *volatile usize = @ptrFromInt(0x0200BFF8);
const MTIMECMP_PTR: *volatile usize = @ptrFromInt(0x0200_4000);

const CLOCK_SPEED: usize = 1000; // Clock speed is setted in Hz

///
/// Inits timer
///
pub fn timer_init() void {
    // check supervisor interrupts are enabled
    const sie_enabled: bool = interrupts.check_supervisor_interrupts_enabled();
    // Enable if it's not enabled
    if (!sie_enabled) {
        interrupts.enable_external_interrupts();
    }

    // check supervisor level timer interrupts are enabled
    const ssie_enabled: bool = interrupts.check_supervisor_timer_interrupts_enabled();
    // Enable if it's not enabled
    if (!ssie_enabled) {
        interrupts.enable_supervisor_timer_interrupts();
    }
    uart.debug("supervisor timer interrupts are enabled\n", .{});
}

pub fn rdtime_get() usize {
    return asm ("rdtime  %[ret]"
        : [ret] "=r" (-> usize),
    );
}
pub fn create_timer() void {
    const time: usize = rdtime_get();
    const cmp: usize = time + 100000000; // add 10000 ticks to current time and set timer into it
    // When timer ticks into our cmp tick, it's gonna send an interrupt to cpu
    asm volatile ("csrw stimecmp, %[cmp]"
        :
        : [cmp] "r" (cmp),
    );
}
pub fn mtime_get() usize {
    return MTIME_PTR.*;
}
