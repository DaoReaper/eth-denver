console.log(`Calculate if the dao should liquidate ${args}`)

// make sure arguments are provided
if (!args || args.length === 0) { 
  return new Error("input not provided: ", args)
}

const [nums, weights] = args
const numsArray = nums.split(", ")
const weightsArray = weights.split(", ")
if (numsArray.length !== weightsArray.length) throw new Error("Nums and weight must be the same length:", numsArray, weightsArray)
console.log(`nums: ${numsArray}`, `weights: ${weightsArray}`)

const weightedAverage = (nums, weights) => {
  const [sum, weightSum] = weights.reduce(
    (acc, w, i) => {
      acc[0] = parseInt(acc[0]) + parseInt(nums[i]) * parseInt(w)
      acc[1] = parseInt(acc[1]) + parseInt(w)
      return acc
    },
    [0, 0]
  )
  return sum / weightSum
}

const weightedAverageResult = weightedAverage(numsArray, weightsArray)
console.log("Result", weightedAverageResult)
// const product = args.reduce((accumulator, currentValue) => {
//   const numValue = parseInt(currentValue)
//   if (isNaN(numValue)) throw Error(`${currentValue} is not a number`)
//   return accumulator + numValue
// }, 0) // calculate the product of numbers provided in args array

// const geometricMean = Math.pow(product, 1 / args.length) // geometric mean = length-root of (product)
// console.log(`geometric mean is: ${geometricMean.toFixed(2)}`)

// Decimals are not handled in Solidity so multiply by 100 (for 2 decimals) and round to the nearest integer
// Functions.encodeUint256: Return a buffer from uint256
return Functions.encodeUint256(Math.round(weightedAverageResult))
