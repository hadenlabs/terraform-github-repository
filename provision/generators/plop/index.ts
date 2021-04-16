import { NodePlopAPI } from 'node-plop'
import { testGenerator } from './generators'
interface PrettifyCustomActionData {
  path: string
}

export default function plop(plop: NodePlopAPI) {
  plop.setGenerator('test', testGenerator)
}
