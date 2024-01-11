import { util } from '@aws-appsync/utils';

/**
 * Called before the request function of the first AppSync function in the pipeline.
 *  @param ctx the context object holds contextual information about the function invocation.
 */
export function request(ctx) {  
  const input = ctx.arguments.input;  
  const attributeValues = util.dynamodb.toMapValues(input);
  ctx.stash.allowedGroups = ['admin'];
  ctx.stash.startedAt = util.time.nowISO8601();
   return {
     operation: 'PutItem',
    key: util.dynamodb.toMapValues({ id: input.accountToken }), // Make sure `id` is part of your input
    attributeValues,
  };
}

/**
 * Called after the response function of the last AppSync function in the pipeline.
 * @param ctx the context object holds contextual information about the function invocation.
 */
export function response(ctx) {    
  const { error, result } = ctx;
  if (error) {
    if (!ctx.stash.errors) ctx.stash.errors = []
    ctx.stash.errors.push(ctx.error)
    return util.appendError(error.message, error.type, result);
  }
  return {
    success:true,
    message:"application was submitted successfully",    
    };
}