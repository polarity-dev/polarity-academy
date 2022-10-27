export { fakerGenerator }

import { writeFile } from "fs"
import { LoremIpsum } from "Lorem-ipsum"
import path from "path"
import Debug from "debug"

const debug = Debug("faker")
Debug.enable("*")

const lorem = new LoremIpsum({
  sentencesPerParagraph: {
    max: 8,
    min: 4
  },
  wordsPerSentence: {
    max: 16,
    min: 4
  }
})

function getRandomNumber(max: number, min = 0): number {
  return Math.trunc(Math.random() * (max - min)) + min
}

function getDummyData(): string {
  return lorem.generateWords(5).split(" ").join("_")
}

const fakerGenerator = async function(destination: string): Promise<void> {
  const maxElements = getRandomNumber(50, 1)
  const firstNumber = getRandomNumber(maxElements)
  const secondNumber = getRandomNumber(maxElements + 1, firstNumber + 1)
  let ctx = [firstNumber, secondNumber].join(" ") + "\n"

  for (let i = 0; i < maxElements; i++) {
    ctx += [getRandomNumber(6, 1), getRandomNumber(1000, -1000), getDummyData()].join(" ") + "\n"
  }

  writeFile(path.join(__dirname, destination), ctx, function(err) {
    if (err) {
      debug("%O", err)
    } else {
      debug("written faker")
    }
  })
}

void fakerGenerator("../../fakerData.txt")