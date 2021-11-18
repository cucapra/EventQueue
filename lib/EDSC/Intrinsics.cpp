#include "EDSC/Intrinsics.h"

ValueRange LaunchOpBuilder(Value start, Value device,
  ValueRange operands, function_ref<void(ValueRange)> bodyBuilder){
  // Fetch the builder and location.
  assert(ScopedContext::getContext() && "EDSC ScopedContext not set up");
  OpBuilder &builder = ScopedContext::getBuilderRef();
  Location loc = ScopedContext::getLocation();

  // Create the actual loop and call the body builder, if provided, after
  // updating the scoped context.
  return builder.create<equeue::LaunchOp>(loc, start, device, operands, 
    [&](OpBuilder &nestedBuilder, Location nestedLoc, ValueRange deviceControl) {
      if (bodyBuilder) {
        ScopedContext nestedContext(nestedBuilder, nestedLoc);
        OpBuilder::InsertionGuard guard(nestedBuilder);
        bodyBuilder(deviceControl);
      }
    }
  ).getResults();
}

