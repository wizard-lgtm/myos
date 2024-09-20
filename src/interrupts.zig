const uart = @import("./drivers/uart.zig");

pub fn set_trap_handler(trap_handler_ptr: *const fn () void) void {
    asm volatile ("csrw mtvec, %[trap_handler_ptr]"
        :
        : [trap_handler_ptr] "r" (trap_handler_ptr),
    );
    return;
}

pub fn trap_handler() void {
    uart.print("Trap occured");
    uart.print("Unimplemented!");
}
pub fn exception_handler() void {
    uart.print("Exception occured");
    uart.print("Unimplemented!");
}
pub fn interrupt_handler() void {
    uart.print("Interrupt occured");
    uart.print("Unimplemented!");
}
pub fn panic_handler() void {
    uart.print("Kernel panic occured");
    uart.print("Unimplemented!");
}
