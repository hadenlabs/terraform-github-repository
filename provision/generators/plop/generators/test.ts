import { Actions, PlopGeneratorConfig } from 'node-plop'
import slugify from 'slugify'
import * as path from 'path'
import { baseGeneratorPath, baseTemplatesPath, pathExists, pathMake } from '../utils'

export enum TestPrompNames {
  'testName' = 'testName',
}

type Answers = { [P in TestPrompNames]: string }

const testPath = path.join(baseGeneratorPath, 'test')

export const testGenerator: PlopGeneratorConfig = {
  description: 'add an path to test',
  prompts: [
    {
      type: 'input',
      name: TestPrompNames.testName,
      message: 'What should it be test?',
      default: 'basic',
    },
  ],
  actions: (data) => {
    const answers = data as Answers
    const containerPath = `${testPath}/repository-${slugify(answers.testName, '-')}`

    if (!pathExists(containerPath)) {
      pathMake(containerPath)
    }

    const actions: Actions = []

    actions.push({
      type: "add",
      templateFile: `${baseTemplatesPath}/test.append.hbs`,
      path: `${testPath}/repository_${slugify(answers.testName, '_')}_test.go`,
      abortOnFail: true,
    })

    actions.push({
      type: "add",
      templateFile: `${baseTemplatesPath}/test/main.append.hbs`,
      path: `${containerPath}/main.tf`,
      abortOnFail: false,
    })

    actions.push({
      type: "add",
      templateFile: `${baseTemplatesPath}/test/outputs.append.hbs`,
      path: `${containerPath}/outputs.tf`,
      abortOnFail: true,
    })

    actions.push({
      type: "add",
      templateFile: `${baseTemplatesPath}/test/provider.append.hbs`,
      path: `${containerPath}/provider.tf`,
      abortOnFail: true,
    })

    actions.push({
      type: "add",
      templateFile: `${baseTemplatesPath}/test/variables.append.hbs`,
      path: `${containerPath}/variables.tf`,
      abortOnFail: true,
    })

    actions.push({
      type: "add",
      templateFile: `${baseTemplatesPath}/test/versions.append.hbs`,
      path: `${containerPath}/versions.tf`,
      abortOnFail: true,
    })

    return actions
  },
}
